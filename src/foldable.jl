struct Foldable{C}
    title::String
    content::C
end


fboxstyle = """
	<style>
details > summary {
  padding: 2px 6px;
  background-color: #ccf;
  border: none;
  <!-- box-shadow: 3px 3px 4px black; -->
  cursor: pointer;
border-radius: 0 25px 25px 0 ;
	border-width:0 0 0 5px;
	border-color: green;
}

details {
  border-radius: 0 0 10px 10px;
  background-color: #ccf;
  padding: 2px 6px;
  margin: 0;
  <!-- box-shadow: 3px 3px 4px black; -->
border-radius: 0 25px 25px 0 ;
	border-width:0 0 0 5px;
	border-color: green;
}

details[open] > summary {
  background-color: #ccf;
}

</style>	
"""
	
function Base.show(io, mime::MIME"text/html", fld::Foldable)

	write(io, fboxstyle)
	write(io,"""<details><summary>$(fld.title)</summary><p>""")
    show(io, mime, fld.content)
    write(io,"</p></details>")
end

function fbox(str::Markdown.MD, title = "参考答案")
	Foldable(title,str)
end
