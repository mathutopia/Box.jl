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
    <!--任务设置CSS--> 
    .task {
		border-style: dotted solid solid;
		border-radius: 0px 25px 25px 0px ;
		border-width:0 0 0 0px;
		border-color: green;
		
		background-color:#ccf;
		font-size: 30px
	}

    <!--折叠框设置css--> 
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

""")