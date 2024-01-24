import { PrismaClient } from '@prisma/client/'
const prisma = new PrismaClient()

async function main() {
//    const user = await prisma.user.create({data : {name:"Sally"}})
    //console.log(user)

    const createdStudent = await prisma.student.create({
      data: {
        name: "John Doe", // replace with the actual student details
        role: "BASIC",    // replace with the actual role
        
      },
    });

    const createdStudentMany = await prisma.student.createMany({
      data: [{
        name: "lol", // replace with the actual student details
        role: "BASIC",    // replace with the actual role
      },{
        name:"lol2",
        role:"ADMIN"
      }],
    });

    // console.log(createdStudentMany)

    const secondStudent = await prisma.student.findUnique({
      where: {
        id:1
        
      }
    })

    const updateUser = await prisma.student.update({
      where: {
        id: 1,
      },
      data: {
        name: 'changed',
      },
    })
    // console.log(updateUser)

    //console.log(secondStudent)

    const manyStudent = await prisma.student.findMany({
      where: {
        name: {
          startsWith:"Jo"
        }
      },
      orderBy:{
        id:'desc'
      }
    })

    // console.log(manyStudent)

    const createdModule1 = await prisma.modules.create({
      data: {
        name: "Module 1",  // replace with the actual module details
        credit: 3,         // replace with the actual credit
        joined: new Date(), // replace with the actual joined date
        students: {
          connect: {
            id: 1, // connect the module to the created student
          },
        }, //
      },
    });
    
    const studentWithModules = await prisma.student.findUnique({
      where: {
        id: 1,
      },
      include: {
        modules: true, // Include the related modules
      },
    });
  
    // console.log(studentWithModules)

    const updatedManyStudent = await prisma.student.updateMany({
      where: { name: 'lol' },
      data: { name: 'Propername' },
    })
      
    const newBooks = await prisma.books.create({
      data: 
        { name: 'Book 1', price: 10.99, 
            student: { connect: { id: 1 } 
        } 
        }

    });
    const newBooks2 = await prisma.books.create({
      data: 
        { name: 'Book 2', price: 12.99, 
            student: { connect: { id: 1 } 
        } 
        }

    });

    // console.log(newBooks)
    
    const booksForSpecificStudent = await prisma.student.findUnique({
      where: {
        id: 1,
      },
      select: {
        book: true,
      },
    });
    
    console.log(booksForSpecificStudent?.book);

  
}

main().catch(e => {
    console.error(e.message)
}).finally(async () =>{
    await prisma.$disconnect()
})