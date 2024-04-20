using HypertextLiteral 

# 这里是一些html元素

function hline(color)
    @htl """

    <div class="horizontal-line"></div>
    .horizontal-line {
    border-bottom: 2px solid black;
    }
"""
end

