#设置题目的CSS

using HypertextLiteral
setcss() = @htl(
"""
<style>
.timu {
    border-style:dotted solid solid;
    border-radius: 0 25px 25px 0 ;
    border-width:0 0 0 5px;
    border-color: green;
    background-color:#ccf;
}

.extitle {
		border-style:dotted solid solid;
		border-radius: 25px 25px 25px 25px ;
		border-width:0 0 0 0px;
		border-color: green;
		text-align: center; 
		background-color:#ccf;
		font-size: 60px
	}

    .section {
		border-style:dotted solid solid;
		border-radius: 25px 25px 25px 25px ;
		border-width:0 0 0 0px;
		border-color: green;
		text-align: center; 
		background-color:#ccf;
		font-size: 50px
	}

    .task {
		border-style: dotted solid solid;
		border-radius: 0px 25px 25px 0px ;
		border-width:0 0 0 0px;
		border-color: green;
		
		background-color:#ccf;
		font-size: 30px
	}
    
</style>

""")