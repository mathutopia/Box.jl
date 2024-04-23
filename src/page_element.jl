

using Markdown
# =================题目========================
struct Timu{C}
    content::C
end

function Base.show(io, mime::MIME"text/html", ex::Timu)
	write(io,"""<div class = "timu">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function timu(str::Markdown.MD)
	Timu(str)
end


# =================实验大标题========================
struct Title{C}
    content::C
end

function Base.show(io, mime::MIME"text/html", ex::Title)
	# write(io, titlestyle)
	write(io,"""<div class = "extitle">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function shiyan(str::Markdown.MD)
	Title(str)
end


#== 节标题===============================================#
struct Section{C}
    content::C
end



function Base.show(io, mime::MIME"text/html", ex::Section)
	# write(io, sectionstyle)
	write(io,"""<div class = "section">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function section(str::Markdown.MD)
	bt = match(r"#.*\n",string(str)).match
	bt = strip(bt, ['\n','#',' '])
	bt = replace(bt, [' ', ':','_'] => '-')

	filename(str) = match(r".*\.jl",str).match

	fn = filename(basename(@__FILE__))
	@show fn
	
	if occursin("backup", fn)
		return str
	end

	chapter = split(@__DIR__, "\\")[end]
	@show fn
	section = match(r"[\d]+", fn).match
	
	
	fn = fn[1:end-3]
	
	open("../toc.txt","a") do f
           write(f,  chapter, ',',section, ',', bt, ',',fn,'\n')
    end
	
	open("../toc.txt","a") do f
           write(f,  chapter, ',',section, ',', bt, ',',fn,'\n')
    end
	return Section(str)
end


# =================实验任务========================
struct Task{C}
    content::C
end

function Base.show(io, mime::MIME"text/html", ex::Task)
	# write(io, taskstyle)
	write(io,"""<div class = "task">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function renwu(str::Markdown.MD)
	Task(str)
end


# =================折叠框========================
struct Foldable{C}
    title::String
    content::C
end


	
function Base.show(io, mime::MIME"text/html", fld::Foldable)

	write(io,"""<details><summary>$(fld.title)</summary><p>""")
    show(io, mime, fld.content)
    write(io,"</p></details>")
end

function fbox(str::Markdown.MD, title = "参考答案")
	Foldable(title,str)
end
