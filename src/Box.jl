module Box

# Write your package code here.

include("boxs.jl")
export box

include("page_element.jl")
export timu, shiyan, renwu,section, fbox, biaoti,maketoc

include("utils.jl")
export print_subtypes, print_supertypes, -->, INFO,is_pluto_file,extract_title,read_pluto_title

include("html.jl")
export drawline, maketoc

include("styles.jl")
export setcss


end
