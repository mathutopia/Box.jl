using Markdown

function _box(color::Symbol = :green, title::Union{String,Nothing} = nothing)
	#@assert color in [:green, :yellow, :blue, :red]
	function green(text)
   		Markdown.MD(Markdown.Admonition("tip", ifelse(isnothing(title),"✍🏻️  插播", title), [text])) # 绿色
	end

	function yellow(text)
		Markdown.MD(Markdown.Admonition("warning",ifelse(isnothing(title),"👀  注意", title),  [text])) # 黄色
	end

	function blue(text)
		Markdown.MD(Markdown.Admonition("hint", ifelse(isnothing(title),"👁️  提示", title), [text])) # 蓝色
	end

	function red(text)
		Markdown.MD(Markdown.Admonition("danger", ifelse(isnothing(title), "🚦 警告", title), [text])) # 红色
	end

	function other(text)
		Markdown.MD(Markdown.Admonition("info", ifelse(isnothing(title),"", title), [text])) # 默认
	end

	if color == :green
		return green
	elseif color == :yellow
		return yellow
	elseif color == :blue
		return blue
	elseif color == :red
		return red
	else
		return other
	end
	
end



#如果直接用名字， 相当于提供信息。
box(text::Markdown.MD) = _box(:green,nothing)(text)

# 如果直接用hint， 相当于提示：
hint(text::Markdown.MD) = _box(:blue,nothing)(text)
hintbox(text::Markdown.MD) = box(:blue,"")(text)
# 如果直接用无参数box， 相当于给出一个真正的框。
box() = _box(:green, "")
# 只给颜色， 用默认标题， 不需要标题， 需要用空字符串表示
box(color::Symbol) = _box(color, nothing)
box(title::String) = _box(:green, title) # 只给文本， 默认就是绿色
# 文本和颜色，可以交换着给
box(title::String, color::Symbol) = _box(color, title)
# 如果给两个Symbol， 则后一个当成标题
box(color::Symbol, title::Symbol) = _box(color, String(title))
# 如果给两个Stiring， 则前一个当成颜色
box(color::String, title::String) = _box(Symbol(color), title)