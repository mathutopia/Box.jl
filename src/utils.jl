	
--> = |> 



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