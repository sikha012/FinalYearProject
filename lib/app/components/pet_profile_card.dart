import 'package:flutter/material.dart';
import 'package:happytails/app/data/models/pet_profile.dart';
import 'package:happytails/app/utils/constants.dart';

class PetProfileCard extends StatelessWidget {
  final PetProfile petProfile;
  const PetProfileCard({super.key, required this.petProfile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.shade400,
                //     spreadRadius: 2,
                //     blurRadius: 2,
                //     offset: Offset(0, 2),
                //   ),
                // ],
                border: Border.all(
                  width: 0.5,
                ),
              ),
              child: Hero(
                tag: 'product+${petProfile.petId}',
                child: Image.network(
                  getImage(
                    petProfile.petImage,
                  ),
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petProfile.petName?.toUpperCase() ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        petProfile.petAge.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'OwnerID: ${petProfile.ownerId ?? ''}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
