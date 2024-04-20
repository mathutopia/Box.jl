

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

