using Markdown
# =================练习========================
struct Exercise{C}
    content::C
end

exerstyle = """
<style>
.exercise {
	border-style:dotted solid solid;
    border-radius: 0 25px 25px 0 ;
	border-width:0 0 0 5px;
	border-color: green;
	background-color:#ccf;
}
</style>

"""

function Base.show(io, mime::MIME"text/html", ex::Exercise)

	write(io, exerstyle)
	write(io,"""<div class = "exercise">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function timu(str::Markdown.MD)
	Exercise(str)
end


# =================实验大标题========================
struct Title{C}
    content::C
end

titlestyle = """
<style>
.extitle {
	border-style:dotted solid solid;
    border-radius: 25px 25px 25px 25px ;
	border-width:0 0 0 0px;
	border-color: green;
	text-align: center; 
	background-color:#ccf;
	font-size: 60px
}
</style>

"""

function Base.show(io, mime::MIME"text/html", ex::Title)

	write(io, titlestyle)
	write(io,"""<div class = "extitle">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function shiyan(str::Markdown.MD)
	Title(str)
end


# =================实验任务========================
struct Task{C}
    content::C
end



taskstyle = """
<style>
.task {
	border-style: dotted solid solid;
    border-radius: 0px 25px 25px 0px ;
	border-width:0 0 0 0px;
	border-color: green;
	
	background-color:#ccf;
	font-size: 30px
}
</style>

"""

function Base.show(io, mime::MIME"text/html", ex::Task)

	write(io, taskstyle)
	write(io,"""<div class = "task">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function renwu(str::Markdown.MD)
	Task(str)
end