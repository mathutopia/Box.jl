
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


filename() = match(r".*\.jl",basename(@__FILE__)).match
updirname() = split(@__DIR__, "\\")[end]
start_num(str) = match(r"[\d]+", str).match
fname(str) =  str[1:end-3]

function biaoti(str::Markdown.MD)
	bt = match(r"#.*\n",string(str)).match
	bt = strip(bt, ['\n','#',' '])
	bt = replace(bt, [' ', ':','_'] => '-')

	fn = filename()
	
	
	if occursin("backup", fn)
		return str
	end

	chapter = updirname()
	section = start_num(fn)
	
	
	fn = fname(fn)
	
	open("../toc.txt","a") do f
           write(f,  chapter, ',',section, ',', bt, ',',fn,'\n')
    end
	return str
end


function maketoc(git="https://mathutopia.github.io")
	toc = read("toc.txt",String)
	toc = unique(split(strip(toc,'\n'), "\n"))
	pkgn = split(dirname(@__FILE__),"\\")[end]
	toc = [split(t,',') for t in toc]
	sort!(toc, by = x->x[1])
	
	render_url(c) = join([git, pkgn, c[1], c[4] ],"/")

	render_row(c) = @htl("""
	
      <li> <a href=$(render_url(c))> $(c[1]) - $(c[3]) </a> </li>
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