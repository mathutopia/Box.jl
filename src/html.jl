using HypertextLiteral 

# 这里是一些html元素

function hline( linewidth::Integer = 2 ,color::Union{String, Symbol} = "black")
	color = isa(color, Symbol) ? string(color) : color
    @htl """

    <div class="horizontal-line">   </div>
	<style>

    .horizontal-line {
        
        border-bottom: $(linewidth)px solid $color;
        
    }
	</style>
"""
end

hline(color::Union{String, Symbol}) = hline(2, color)
hline(color::Union{String, Symbol}, n::Integer) = hline(n, color)





function maketoc(git="https://mathutopia.github.io")
	toc = read("toc.txt",String)
	toc = unique(split(strip(toc,'\n'), "\n"))
	pkgn = split(dirname(@__FILE__),"\\")[end]
	toc = [split(t,',') for t in toc]

	

	render_url(c) = join([git, pkgn, c[4] ],"/")

	render_row(c) = @htl("""
	
      <li> <a href=$(render_url(c))> $(c[3]) </a> </li>
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
        .toc {        
                margin-bottom: 10px;
                padding: 8px;
                background-color: #f0f0f0;
                border: 1px solid #ddd;
                border-radius: 4px;      
        }
	</style>
  """)
	render_table(toc)
end
