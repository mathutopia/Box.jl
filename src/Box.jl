module Box

# Write your package code here.

include("boxs.jl")
export box

include("page_element.jl")
export timu, shiyan, renwu,section, fbox, biaoti,maketoc

include("utils.jl")
export print_subtypes, print_supertypes, -->, INFO

include("html.jl")
export drawline, maketoc

include("styles.jl")
export setcss

testb()="testb message"
end
