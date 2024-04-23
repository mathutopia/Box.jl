
using HypertextLiteral
--> = |> 



function print_supertypes(T)
    println(T)
    T == Any || print_supertypes(supertype(T))
    return nothing
end

function print_subtypes(T, indent_level=0)
println(" " ^ indent_level, T)
   for S in subtypes(T)
        print_subtypes(S, indent_level + 2)
   end
   return nothing
end



function biaoti(str::Markdown.MD)
	bt = match(r"#.*\n",string(str)).match
	bt = strip(bt, ['\n','#',' '])
	bt = replace(bt, [' ', ':','_'] => '-')

	fn = match(r".*\.jl",basename(@__FILE__)).match
	
	
	if occursin("backup", fn)
		return str
	end

	chapter = split(@__DIR__, "\\")[end]
	section = match(r"[\d]+", fn).match
	
	
	fn = fn[1:end-3]
	
	open("../toc.txt","a") do f
           write(f,  chapter, ',',section, ',', bt, ',',fn,'\n')
    end
	return str
end


function maketoc()
    toc = read_pluto_title(".")
	
	sort!(toc, by = x->x[1])
	
	render_row(c) = @htl("""
	
      <li> <a href=$(c[4])> 第$(c[1])章 第$(c[2])节——$(c[3]) </a> </li>
    """)

    render_table(list) = @htl("""
    <div id="toc">
        <!-- 目录代码 -->
        <div style="text-align:center;"> <h3> 目录 <h3></div> 
        <ul>
        $((render_row(b) for b in list))
        </ul>
    </div>
    <style>
        #toc {
		  font-family: Arial, sans-serif;
		  background-color: #ccf;
		  padding: 10px;
		}
	</style>
  """)
	render_table(toc)
end

const INFO = md"""
本文件中用到了一个自编的包Box.jl。由于该包没有在公共注册中心注册， 想要使用该包， 需要先安装一个本地的注册中心。方法很简单， 只需要在REPL中执行下面两行代码即可。
```julia
julia> using Pkg
julia> Pkg.Registry.add(RegistrySpec(url = "https://github.com/mathutopia/Wlreg.git"))
```
由于安装本地注册中心需要连接github， 如果网络连接不成功可以多次尝试。直到在REPL中， 输入如下语句， 看到Wlreg就表示注册中心安装成功了。 下面是我本地机器返回的结果。
```julia

julia> Pkg.Registry.status()
Registry Status
 [84dc1479] Wlreg (https://github.com/mathutopia/Wlreg.git)
 [23338594] General (https://github.com/JuliaRegistries/General.git)
```
"""


"""
    read_pluto_title->toc
读取一个文件夹下所有的pluto写的文件的第一个# 之后的文本，当成是标题,并将制作为目录。目录是由（chpn, section, title, url）构成的向量。
"""
function read_pluto_title(dir, git="https://mathutopia.github.io",repo="dplusbook")
    toc = []
    for (root, dirs, files) in walkdir(dir)
        for file in files # 对每一个文件
            if file[end-1:end] == "jl"  # 如果是jl文件               
                fln = join([root, file],"/")
                if !occursin(r"(backup|index)", file) && is_pluto_file(fln) # 如果是pluto写的jl文件
                    title = extract_title(fln) # 提取出标题
                    url = fln[1:end-3]  
                    m = match(r"[.\\/](?<sec>\d+)[\.-]*(?<name>[-_\w]+$)",url)# 匹配文件名中的数字
                    if m === nothing 
                        section = ""
                    else
                        section = m.captures[1]
                    end
                    m = match(r".\\(.*)/", url) # 匹配第一层文件夹名字
                    if m === nothing 
                        chpn = ""
                    else
                        chpn = m.captures[1]
                    end

                    url = replace(url,"."=>join([git,repo],"/"))# 替换成网页路径
                    push!(toc, (chpn, section, title, url))
                end
            end
        end
    end
    return toc
end
"""
    is_pluto_file
判断一个文件是否是一个pluto写的文件
"""

function is_pluto_file(fl)
    firstline = readline(fl)
    return occursin("Pluto.jl", firstline)
end
"""
    extract_title->title
从一个pluto写的文件中提取其标题。默认情况下， 把正文的第一个md字符串中第一个#符号之后的内容当成是标题
"""
function extract_title(fl)
    @assert is_pluto_file(fl) "这不是一个Pluto写的jl文件"
    mdfind = false
    poundfind = false
    for line in eachline(fl)
        if !mdfind && startswith( line, "md\"\"\"")
            mdfind = true
            continue
        end
        
        if mdfind && !poundfind
            poundfind = startswith(line, "# ")
            if poundfind
                # 为什么会匹配到空格， 暂时没明白
               m = match(r"^\s*(?:#\s*(.*?)\s*$|$)", line)
               if m === nothing || m.match === ""  
                    ### 应该还要判断是否一个md结束了，结束的话要重新设置mdfind。
                    continue
               else
                    return m.captures[1]
               end
            end
        end
    end    
end

