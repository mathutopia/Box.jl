using HypertextLiteral 

# 这里是一些html元素

function drawline( linewidth::Integer = 2 ,color::Union{String, Symbol} = "black")
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

drawline(color::Union{String, Symbol}) = hline(2, color)
drawline(color::Union{String, Symbol}, n::Integer) = hline(n, color)




