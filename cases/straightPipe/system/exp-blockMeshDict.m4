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
	(0.25 0 0) //0
	(0 0.25 0) //1
	(-0.25 0 0) //2
	(0 -0.25 0) //3 bottom first cylinder

	(0.25 0 0.05) //4
	(0 0.25 0.05) //5
	(-0.25 0 0.05) //6
	(0 -0.25 0.05) //7 top first cylinder
	
	(0 0 0) //8 center point bottom inlet pipe
	(0 0 0.05) //9 centre point top inlet pipe
	
	(0.01 0 0) //10
	(0 0.01 0) //11
	(-0.01 0 0) //12
	(0 -0.01 0) //13 bottom inlet pipe
	
	(0.01 0 0.05) //14
	(0 0.01 0.05) //15
	(-0.01 0 0.05) //16
	(0 -0.01 0.05) //17 bottom inner cylinder
	
	(0.25 0 1) //18
	(0 0.25 1) //19
	(-0.25 0 1) //20
	(0 -0.25 1) //21 top second cylinder
	
	(0 0 1) //22 centre point top inner cylinder
	
	(0.01 0 1) //23
	(0 0.01 1) //24
	(-0.01 0 1) //25
	(0 -0.01 1) //26 top inner cylinder
	
	
);

blocks //(x_cells equal between all blocks, y_cells equal between first and second cylinder, z_cells at will)
(
	hex (14 15 9 9 23 24 22 22) (25 1 95) simpleGrading (1 1 1) //inner cylinder 
	hex (15 16 9 9 24 25 22 22) (25 1 95) simpleGrading (1 1 1)
	hex (16 17 9 9 25 26 22 22) (25 1 95) simpleGrading (1 1 1)
	hex (17 14 9 9 26 23 22 22) (25 1 95) simpleGrading (1 1 1) 
	
	hex (0 1 11 10 4 5 15 14) (25 24 5) simpleGrading (1 1 1) //first cylinder
	hex (1 2 12 11 5 6 16 15) (25 24 5) simpleGrading (1 1 1)
	hex (2 3 13 12 6 7 17 16) (25 24 5) simpleGrading (1 1 1)
	hex (3 0 10 13 7 4 14 17) (25 24 5) simpleGrading (1 1 1) 
	
	hex (4 5 15 14 18 19 24 23) (25 24 95) simpleGrading (1 1 1) //second cylinder
	hex (5 6 16 15 19 20 25 24) (25 24 95) simpleGrading (1 1 1)
	hex (6 7 17 16 20 21 26 25) (25 24 95) simpleGrading (1 1 1)
	hex (7 4 14 17 21 18 23 26) (25 24 95) simpleGrading (1 1 1) 
);

edges
(
	arc 0 1 (0.17677 0.17677 0) //(cx+r*cos45 cy+r*sin45 0) bottom first cylinder
	arc 1 2 (-0.17677 0.17677 0) 
	arc 2 3 (-0.17677 -0.17677 0)
	arc 3 0 (0.17677 -0.17677 0)
	
	arc 4 5 (0.17677 0.17677 0.05) // top first cylinder
	arc 5 6 (-0.17677 0.17677 0.05)
	arc 6 7 (-0.17677 -0.17677 0.05)
	arc 7 4 (0.17677 -0.17677 0.05)
	
	arc 10 11 (0.00707 0.00707 0) // bottom inlet pipe
	arc 11 12 (-0.00707 0.00707 0) 
	arc 12 13 (-0.00707 -0.00707 0) 
	arc 13 10 (0.00707 -0.00707 0) 
	
	arc 14 15 (0.00707 0.00707 0.05) // top inlet pipe
	arc 15 16 (-0.00707 0.00707 0.05) 
	arc 16 17 (-0.00707 -0.00707 0.05) 
	arc 17 14 (0.00707 -0.00707 0.05)
	
	arc 18 19 (0.17677 0.17677 1) // top second cylinder
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
	bottom_first_cylinder 
	{
		type wall;
		faces
		(
			(0 10 11 1) 
			(1 11 12 2)
			(2 12 13 3)
			(3 13 10 0)
		);
	}
	first_cylinder_shell 
	{
		type wall;
		faces
		(	
			(0 1 5 4) 
			(1 2 5 6)
			(2 3 7 6)
			(3 0 4 7)
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
			(10 14 15 11) 
			(11 12 15 16)
			(12 13 17 16)
			(13 10 14 17)
		);
	}
	
	//top_first_cylinder
	//{
	//	type patch;
	//	faces
	//	(
	//		(5 15 14 4) 
	//		(6 16 15 5)
	//		(7 17 16 6)
	//		(4 14 17 7)
	//	);
	//}		
	//bottom_second_cylinder
	//{
	//	type patch;
	//	faces
	//	(
	//		(4 14 15 5) 
	//		(5 15 16 6)
	//		(6 16 17 7)
	//		(7 17 14 4)
	//	);
	//}
	//inner_cylinder_shell
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
	//second_cylinder_internal_shell
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
	
	inlet_pipe_top
	{
		type patch;
		faces
		(
			(14 9 9 15) 
			(15 9 9 16)
			(16 9 9 17)
			(17 9 9 14)
		);
	}
	
	outlet_second_cylinder
	{
		type patch;
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
		type patch;
		faces
		(
			(23 22 22 24) 
			(24 22 22 25)
			(25 22 22 26)
			(26 22 22 23)
		);
	}	
);

mergePatchPairs
(

);		


// ************************************************************************* //
