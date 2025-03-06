// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// /// Custom exception for Firebase operations
// class FirebaseOperationException implements Exception {
//   final String message;
//   final dynamic originalError;

//   FirebaseOperationException(this.message, [this.originalError]);

//   @override
//   String toString() =>
//       'FirebaseOperationException: $message${originalError != null ? '\nOriginal error: $originalError' : ''}';
// }

// /// Enhanced file upload utility with progress tracking and metadata support
// class FirebaseStorageService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   /// Uploads a file with metadata and progress tracking
//   Future<UploadResult> uploadFileWithMetadata({
//     required File file,
//     required String path,
//     Map<String, String>? metadata,
//     Function(double)? onProgress,
//   }) async {
//     // Check if the user is authenticated
//     final User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw FirebaseOperationException('User is not authenticated');
//     }

//     try {
//       final Reference ref = _storage.ref().child(path);
//       final SettableMetadata settableMetadata = SettableMetadata(
//         contentType: _getContentType(file.path),
//         customMetadata: metadata,
//       );

//       final UploadTask uploadTask = ref.putFile(file, settableMetadata);

//       // Track upload progress
//       if (onProgress != null) {
//         uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//           final double progress =
//               snapshot.bytesTransferred / snapshot.totalBytes;
//           onProgress(progress);
//         });
//       }

//       final TaskSnapshot snapshot = await uploadTask;
//       final String downloadUrl = await snapshot.ref.getDownloadURL();
//       final String fullPath = snapshot.ref.fullPath;

//       return UploadResult(
//         success: true,
//         downloadUrl: downloadUrl,
//         path: fullPath,
//         metadata: await snapshot.ref.getMetadata(),
//       );
//     } catch (e) {
//       throw FirebaseOperationException('Failed to upload file', e);
//     }
//   }

//   String _getContentType(String filePath) {
//     final String extension = filePath.split('.').last.toLowerCase();
//     final Map<String, String> contentTypes = {
//       'jpg': 'image/jpeg',
//       'mp4': 'video/mp4',
//       'jpeg': 'image/jpeg',
//       'png': 'image/png',
//       'gif': 'image/gif',
//       'pdf': 'application/pdf',
//       'doc': 'application/msword',
//       'docx':
//           'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
//     };
//     return contentTypes[extension] ?? 'application/octet-stream';
//   }

//   /// Deletes a file from Firebase Storage
//   Future<void> deleteFile(String path) async {
//     // Check if the user is authenticated
//     final User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw FirebaseOperationException('User is not authenticated');
//     }

//     try {
//       final Reference ref = _storage.ref().child(path);
//       await ref.delete();
//     } catch (e) {
//       throw FirebaseOperationException('Failed to delete file', e);
//     }
//   }
// }

// class UploadResult {
//   final bool success;
//   final String? downloadUrl;
//   final String? path;
//   final FullMetadata? metadata;

//   UploadResult({
//     required this.success,
//     this.downloadUrl,
//     this.path,
//     this.metadata,
//   });
// }

// /// Enhanced Firestore service with advanced operations
// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   /// Creates a document with validation and optional merge
//   Future<DocumentReference> createDocument({
//     required String collection,
//     required Map<String, dynamic> data,
//     String? documentId,
//     bool merge = false,
//   }) async {
//     try {
//       final CollectionReference collectionRef =
//           _firestore.collection(collection);
//       final DocumentReference docRef = documentId != null
//           ? collectionRef.doc(documentId)
//           : collectionRef.doc();

//       await docRef.set(data, SetOptions(merge: merge));
//       return docRef;
//     } catch (e) {
//       throw FirebaseOperationException('Failed to create document', e);
//     }
//   }

//   /// Performs a batch write operation
//   Future<void> batchWrite({
//     required List<BatchOperation> operations,
//   }) async {
//     try {
//       final WriteBatch batch = _firestore.batch();

//       for (final operation in operations) {
//         final docRef = _firestore
//             .collection(operation.collection)
//             .doc(operation.documentId);

//         switch (operation.type) {
//           case BatchOperationType.set:
//             batch.set(docRef, operation.data!,
//                 SetOptions(merge: operation.merge ?? false));
//             break;
//           case BatchOperationType.update:
//             batch.update(docRef, operation.data!);
//             break;
//           case BatchOperationType.delete:
//             batch.delete(docRef);
//             break;
//         }
//       }

//       await batch.commit();
//     } catch (e) {
//       throw FirebaseOperationException('Failed to execute batch operation', e);
//     }
//   }

//   /// Performs a transaction with retry logic
//   Future<T> runTransaction<T>({
//     required Future<T> Function(Transaction) transactionHandler,
//     int maxAttempts = 3,
//   }) async {
//     int attempts = 0;
//     while (attempts < maxAttempts) {
//       try {
//         return await _firestore.runTransaction(transactionHandler);
//       } catch (e) {
//         attempts++;
//         if (attempts >= maxAttempts) {
//           throw FirebaseOperationException(
//             'Transaction failed after $maxAttempts attempts',
//             e,
//           );
//         }
//         await Future.delayed(Duration(seconds: attempts));
//       }
//     }
//     throw FirebaseOperationException('Transaction failed unexpectedly');
//   }

//   /// Queries documents with pagination support
//   Future<QueryResult> queryDocuments({
//     required String collection,
//     QueryFilter? filter,
//     String? orderBy,
//     bool descending = false,
//     int? limit,
//     DocumentSnapshot? startAfter,
//   }) async {
//     try {
//       Query query = _firestore.collection(collection);

//       if (filter != null) {
//         query = _applyFilter(query, filter);
//       }

//       if (orderBy != null) {
//         query = query.orderBy(orderBy, descending: descending);
//       }

//       if (limit != null) {
//         query = query.limit(limit);
//       }

//       if (startAfter != null) {
//         query = query.startAfterDocument(startAfter);
//       }

//       final QuerySnapshot snapshot = await query.get();

//       return QueryResult(
//         documents: snapshot.docs,
//         hasMore: snapshot.docs.length == limit,
//         lastDocument: snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
//       );
//     } catch (e) {
//       throw FirebaseOperationException('Failed to query documents', e);
//     }
//   }

//   Query _applyFilter(Query query, QueryFilter filter) {
//     switch (filter.operator) {
//       case FilterOperator.equals:
//         return query.where(filter.field, isEqualTo: filter.value);
//       case FilterOperator.greaterThan:
//         return query.where(filter.field, isGreaterThan: filter.value);
//       case FilterOperator.lessThan:
//         return query.where(filter.field, isLessThan: filter.value);
//       case FilterOperator.contains:
//         return query.where(filter.field, arrayContains: filter.value);
//     }
//   }

//   /// Subscribes to real-time document updates
//   Stream<DocumentSnapshot> subscribeToDocument({
//     required String collection,
//     required String documentId,
//   }) {
//     return _firestore.collection(collection).doc(documentId).snapshots();
//   }

//   /// Subscribes to real-time query results
//   Stream<QuerySnapshot> subscribeToQuery({
//     required String collection,
//     QueryFilter? filter,
//     String? orderBy,
//     bool descending = false,
//     int? limit,
//   }) {
//     Query query = _firestore.collection(collection);

//     if (filter != null) {
//       query = _applyFilter(query, filter);
//     }

//     if (orderBy != null) {
//       query = query.orderBy(orderBy, descending: descending);
//     }

//     if (limit != null) {
//       query = query.limit(limit);
//     }

//     return query.snapshots();
//   }
// }

// /// Supporting classes for batch operations
// enum BatchOperationType { set, update, delete }

// class BatchOperation {
//   final String collection;
//   final String documentId;
//   final BatchOperationType type;
//   final Map<String, dynamic>? data;
//   final bool? merge;

//   BatchOperation({
//     required this.collection,
//     required this.documentId,
//     required this.type,
//     this.data,
//     this.merge,
//   });
// }

// /// Supporting classes for queries
// enum FilterOperator {
//   equals,
//   greaterThan,
//   lessThan,
//   contains,
// }

// class QueryFilter {
//   final String field;
//   final FilterOperator operator;
//   final dynamic value;

//   QueryFilter({
//     required this.field,
//     required this.operator,
//     required this.value,
//   });
// }

// class QueryResult {
//   final List<DocumentSnapshot> documents;
//   final bool hasMore;
//   final DocumentSnapshot? lastDocument;

//   QueryResult({
//     required this.documents,
//     required this.hasMore,
//     this.lastDocument,
//   });
// }

// void main() async {
//   final storageService = FirebaseStorageService();
//   final firestoreService = FirestoreService();

//   // Example usage of the services
//   try {
//     // Create a user profile
//     final userProfile = await firestoreService.createDocument(
//       collection: 'users',
//       documentId: 'user123',
//       data: {
//         'name': 'John Doe',
//         'email': 'john@example.com',
//         'createdAt': FieldValue.serverTimestamp(),
//       },
//       merge: true,
//     );
//     log('User profile created: ${userProfile.id}');

//     // Upload a profile picture
//     final File imageFile = File('path/to/profile.jpg');
//     if (await imageFile.exists()) {
//       final uploadResult = await storageService.uploadFileWithMetadata(
//         file: imageFile,
//         path: 'users/${userProfile.id}/profile.jpg',
//         metadata: {'userId': userProfile.id},
//         onProgress: (progress) {
//           log('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
//         },
//       );

//       if (uploadResult.success && uploadResult.downloadUrl != null) {
//         // Update user profile with profile picture URL
//         await firestoreService.createDocument(
//           collection: 'users',
//           documentId: userProfile.id,
//           data: {'profilePictureUrl': uploadResult.downloadUrl},
//           merge: true,
//         );
//         log('Profile picture uploaded and user updated');
//       }
//     }

//     // Set up real-time listener for user updates
//     firestoreService
//         .subscribeToDocument(
//       collection: 'users',
//       documentId: userProfile.id,
//     )
//         .listen(
//       (snapshot) {
//         if (snapshot.exists) {
//           log('User data updated: ${snapshot.data()}');
//         }
//       },
//       onError: (error) => log('Error listening to user updates: $error'),
//     );

//     // Perform a batch operation
//     await firestoreService.batchWrite(
//       operations: [
//         BatchOperation(
//           collection: 'users',
//           documentId: userProfile.id,
//           type: BatchOperationType.update,
//           data: {'lastLogin': FieldValue.serverTimestamp()},
//         ),
//         BatchOperation(
//           collection: 'userStats',
//           documentId: userProfile.id,
//           type: BatchOperationType.set,
//           data: {'loginCount': 1},
//           merge: true,
//         ),
//       ],
//     );

//     // Query for users
//     final queryResult = await firestoreService.queryDocuments(
//       collection: 'users',
//       filter: QueryFilter(
//         field: 'createdAt',
//         operator: FilterOperator.lessThan,
//         value: DateTime.now(),
//       ),
//       orderBy: 'createdAt',
//       descending: true,
//       limit: 10,
//     );

//     log('Found ${queryResult.documents.length} recent users');
//   } catch (e) {
//     if (e is FirebaseOperationException) {
//       log('Firebase operation failed: ${e.message}');
//       if (e.originalError != null) {
//         log('Original error: ${e.originalError}');
//       }
//     } else {
//       log('Unexpected error: $e');
//     }
//   }
// }

// // Additional examples
// void additionalExamples() async {
//   final storageService = FirebaseStorageService();
//   final firestoreService = FirestoreService();

//   // Upload file with progress tracking
//   final file = File('assets/images/null.jpg');
//   final uploadResult = await storageService.uploadFileWithMetadata(
//     file: file,
//     path: 'uploads/profile_pictures/user123.jpg',
//     metadata: {'userId': 'user123'},
//     onProgress: (progress) {
//       log('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
//     },
//   );

//   // Batch write operation
//   await firestoreService.batchWrite(
//     operations: [
//       BatchOperation(
//         collection: 'users',
//         documentId: 'user123',
//         type: BatchOperationType.set,
//         data: {'name': 'John Doe'},
//         merge: true,
//       ),
//       BatchOperation(
//         collection: 'users',
//         documentId: 'user456',
//         type: BatchOperationType.delete,
//       ),
//     ],
//   );

//   // Query with pagination
//   final queryResult = await firestoreService.queryDocuments(
//     collection: 'users',
//     filter: QueryFilter(
//       field: 'age',
//       operator: FilterOperator.greaterThan,
//       value: 18,
//     ),
//     orderBy: 'name',
//     limit: 20,
//   );

//   // Subscribe to real-time updates
//   firestoreService
//       .subscribeToDocument(
//     collection: 'users',
//     documentId: 'user123',
//   )
//       .listen((snapshot) {
//     log('Document updated: ${snapshot.data()}');
//   });
// }
