	
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
	bt = match(r"#.*\n",string(ss)).match
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
	@show toc
	
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
