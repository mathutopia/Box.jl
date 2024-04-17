module Box

# Write your package code here.
using Markdown
export lianx,fenge, attention, danger


function lianx(text, title = "❓ 动手试一试")
    Markdown.MD(Markdown.Admonition("tip", title, [text])) # 绿色
end

function fenge(text, title="")
    Markdown.MD(Markdown.Admonition("tip", title, [text])) # 绿色
end

function attention(text, title = "⚡ 注 意")
    Markdown.MD(Markdown.Admonition("warning", title, [text])) # 黄色
end

function danger(text, title = "💣 危 险")
    Markdown.MD(Markdown.Admonition("danger", title, [text])) # 红色
end

function hint(text, title = "💡提示")
    Markdown.MD(Markdown.Admonition("hint", title, [text])) # 蓝色
end

function kuoz(text, title = "📗 扩展")
    Markdown.MD(Markdown.Admonition("tip", title, [text])) # 绿色
end

#=


# ====================================================
#如果直接用名字， 相当于提供信息。
box(text::Markdown.MD) = box(:green,nothing)(text)

# 如果直接用hint， 相当于提示：
hint(text::Markdown.MD) = box(:blue,nothing)(text)
hintbox(text::Markdown.MD) = box(:blue,"")(text)
# 如果直接用无参数box， 相当于给出一个真正的框。
box() = box(:green, "")
# 只给颜色， 用默认标题， 不需要标题， 需要用空字符串表示
box(color::Symbol) = box(color, nothing)
box(title::String) = box(:green, title) # 只给文本， 默认就是绿色
# 文本和颜色，可以交换着给
box(title::String, color::Symbol) = box(color, title)
# 如果给两个Symbol， 则后一个当成标题
box(color::Symbol, title::Symbol) = box(color, String(title))
# 如果给两个Stiring， 则前一个当成颜色
box(color::String, title::String) = box(Symbol(color), title)

	# ==============

	
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

end


# ╔═╡ 1d957e68-f957-465a-9bbf-5d5487745032
struct Foldable{C}
    title::String
    content::C
end

# ╔═╡ 2da1b144-5ca4-43b1-b352-0cee59a22b70
begin


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

end

# ╔═╡ b216450f-5bda-4fd3-a653-6dc48935e93d
md"""
## 题目定义
下面是定义题目的代码
"""

# ╔═╡ 30026fc0-7d93-41d9-a3ee-d787f6b0652d
	struct Exercise{C}
    content::C
	end

# ╔═╡ ccfa0499-1d08-42d6-b786-3d55dbf1c039
begin
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

end

# ╔═╡ 26cf9160-c1c9-426a-80c5-9748b34afd57
md"""
# 实验标题
"""

# ╔═╡ c62bf0e0-7ae3-4868-9a15-39bab96334da
begin
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

function extitle(str::Markdown.MD)
	Title(str)
end


end

# ╔═╡ 36b48856-e6e9-427d-a244-276a03e53e16
struct Task{C}
    content::C
end

# ╔═╡ 1d36282d-2eaf-43c8-bc47-d15bfa448961
begin
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

function task(str::Markdown.MD)
	Task(str)
end
end

=#
end
