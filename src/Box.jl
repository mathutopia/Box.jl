module Box

# Write your package code here.

include("boxs.jl")
export box


include("foldable.jl")
export fbox

include("exer.jl")
export timu, shiyan, renwu

include("utils.jl")
export print_subtypes, print_supertypes, -->

testmess() = "testmessage"
export testmess

test2() = "test2"
export test2

testmain() = "testmain"
export testmain

end

