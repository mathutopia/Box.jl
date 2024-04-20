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
