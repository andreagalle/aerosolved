/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  4.x                                   |
|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    object      blockMeshDict;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

convertometres 1;

vertices
(
	(0.25 0 -0.1) //0
	(0 0.25 -0.1) //1
	(-0.25 0 -0.1) //2
	(0 -0.25 -0.1) //3 dummy points 

	(0.25 0 0) //4
	(0 0.25 0) //5
	(-0.25 0 0) //6
	(0 -0.25 0) //7 bottom hollow cylinder
	
	(0 0 -0.1) //8 center point bottom inlet pipe
	(0 0 0) //9 center point top inlet pipe
	
	(0.01 0 -0.1) //10
	(0 0.01 -0.1) //11
	(-0.01 0 -0.1) //12
	(0 -0.01 -0.1) //13 bottom inlet pipe
	
	(0.01 0 0) //14
	(0 0.01 0) //15
	(-0.01 0 0) //16
	(0 -0.01 0) //17 bottom inner cylinder
	
	(0.25 0 1) //18
	(0 0.25 1) //19
	(-0.25 0 1) //20
	(0 -0.25 1) //21 top hollow cylinder
	
	(0 0 1) //22 centre point top inner cylinder
	
	(0.01 0 1) //23
	(0 0.01 1) //24
	(-0.01 0 1) //25
	(0 -0.01 1) //26 top inner cylinder
	
	
);

blocks //(x_cells equal between all blocks, y_cells equal between inlet and inner cylinder, z_cells at will)
(
	hex (14 15 9 9 23 24 22 22) (25 1 100) simpleGrading (1 1 1) //inner cylinder 
	hex (15 16 9 9 24 25 22 22) (25 1 100) simpleGrading (1 1 1)
	hex (16 17 9 9 25 26 22 22) (25 1 100) simpleGrading (1 1 1)
	hex (17 14 9 9 26 23 22 22) (25 1 100) simpleGrading (1 1 1) 
	
	hex (10 11 8 8 14 15 9 9) (25 1 10) simpleGrading (1 1 1) //inlet pipe
	hex (11 12 8 8 15 16 9 9) (25 1 10) simpleGrading (1 1 1)
	hex (12 13 8 8 16 17 9 9) (25 1 10) simpleGrading (1 1 1)
	hex (13 10 8 8 17 14 9 9) (25 1 10) simpleGrading (1 1 1) 
	
	hex (4 5 15 14 18 19 24 23) (25 24 100) simpleGrading (1 1 1) //hollow cylinder
	hex (5 6 16 15 19 20 25 24) (25 24 100) simpleGrading (1 1 1)
	hex (6 7 17 16 20 21 26 25) (25 24 100) simpleGrading (1 1 1)
	hex (7 4 14 17 21 18 23 26) (25 24 100) simpleGrading (1 1 1) 
);

edges
(
	arc 4 5 (0.17677 0.17677 0) //(cx+r*cos45 cy+r*sin45 0) bottom holllow cylinder
	arc 5 6 (-0.17677 0.17677 0)
	arc 6 7 (-0.17677 -0.17677 0)
	arc 7 4 (0.17677 -0.17677 0)
	
	arc 10 11 (0.00707 0.00707 -0.1) // bottom inlet pipe
	arc 11 12 (-0.00707 0.00707 -0.1) 
	arc 12 13 (-0.00707 -0.00707 -0.1) 
	arc 13 10 (0.00707 -0.00707 -0.1) 
	
	arc 14 15 (0.00707 0.00707 0) // top inlet pipe
	arc 15 16 (-0.00707 0.00707 0) 
	arc 16 17 (-0.00707 -0.00707 0) 
	arc 17 14 (0.00707 -0.00707 0)
	
	arc 18 19 (0.17677 0.17677 1) // top hollow cylinder
	arc 19 20 (-0.17677 0.17677 1)
	arc 20 21 (-0.17677 -0.17677 1)
	arc 21 18 (0.17677 -0.17677 1)
	
	arc 23 24 (0.00707 0.00707 1) // top inner cylinder
	arc 24 25 (-0.00707 0.00707 1) 
	arc 25 26 (-0.00707 -0.00707 1) 
	arc 26 23 (0.00707 -0.00707 1)
);

boundary
(
	bottom_second_cylinder 
	{
		type wall;
		faces
		(
			(4 14 15 5) 
			(5 15 16 6)
			(6 16 17 7)
			(7 17 14 4)
		);
	}
	
	second_cylinder_shell 
	{
		type wall;
		faces
		(		
			(4 5 19 18) 
			(5 6 19 20)
			(6 7 21 20)
			(7 4 18 21)
		);
	}
	
	inlet_pipe_shell 
	{
		type wall;
		faces
		(		
			(10 11 15 14) 
			(11 12 15 16)
			(12 13 17 16)
			(13 10 14 17)
		);
	}
	
	inlet_pipe_bottom
	{
		type inlet;
		faces
		(
			(10 8 8 11)
			(11 8 8 12)
			(12 8 8 13)
			(13 8 8 10)
		);
	}

	outlet_hollow_cylinder
	{
		type outlet;
		faces
		(
			(18 23 24 19) 
			(19 24 25 20)
			(20 25 26 21)
			(21 26 23 18)
		);
	}
	
	outlet_inner_cylinder
	{
		type outlet;
		faces
		(
			(23 22 22 24) 
			(24 22 22 25)
			(25 22 22 26)
			(26 22 22 23)
		);
	}

	//inner_cylinder_shell  (((faces for mergePatchPairs)))
	//{
	//	type patch;
	//	faces
	//	(	
	//		(14 15 24 23) 
	//		(15 16 24 25)
	//		(16 17 26 25)
	//		(17 14 23 26)
	//	);
	//}
	//
	//hollow_cylinder_internal_shell
	//{
	//	type patch;
	//	faces
	//	(	
	//		()
	//		()
	//		()
	//		()
	//	);
	//}
	//	
	//inlet_pipe_top
	//{
	//	type patch;
	//	faces
	//	(
	//		(15 9 9 14)
	//		(16 9 9 15)
	//		(17 9 9 16)
	//		(14 9 9 17)
	//	);
	//}
	//
	//inner_cylinder_bottom
	//{
	//	type patch;
	//	faces
	//	(
	//		(14 9 9 15) 
	//		(15 9 9 16)
	//		(16 9 9 17)
	//		(17 9 9 14)
	//	);
	//}
	
);

mergePatchPairs
(

);		


// ************************************************************************* //
