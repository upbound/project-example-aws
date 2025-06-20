import models.com.example.platform.v1alpha1 as platformv1alpha1
import models.io.upbound.aws.s3.v1beta1 as s3v1beta1
import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1

_items = [
    metav1alpha1.CompositionTest{
        metadata.name="test-xstoragebucket"
        spec= {
            assertResources: [
                platformv1alpha1.XStorageBucket{
                    metadata.name: "example"
                    spec: {
                        parameters: {
                            acl: "public-read"
                            region: "us-west-1"
                            versioning: True
                        }
                    }
                }
                s3v1beta1.BucketACL{
                    metadata.name: "example-acl"
                    spec.forProvider:{
                        acl: "public-read"
                        bucketRef: {
                            name: "example-bucket"
                        }
                        region: "us-west-1"
                    }
                }
                s3v1beta1.BucketOwnershipControls{
                    metadata.name: "example-boc"
                    spec.forProvider: {
                        bucketRef: {
                            name: "example-bucket"
                        }
                        region: "us-west-1"
                        rule: [
                            {
                                objectOwnership: "BucketOwnerPreferred"
                            }
                        ]
                    }
                }
                s3v1beta1.Bucket{
                    metadata.name: "example-bucket"
                    spec.forProvider: {
                        region: "us-west-1"
                    }
                }
                s3v1beta1.BucketServerSideEncryptionConfiguration{
                    metadata.name: "example-encryption"
                    spec.forProvider: {
                        bucketRef: {
                            name: "example-bucket"
                        }
                        region: "us-west-1"
                        rule: [
                            {
                                applyServerSideEncryptionByDefault: [
                                    {
                                        sseAlgorithm: "AES256"
                                    }
                                ]
                                bucketKeyEnabled: True
                            }
                        ]
                    }
                }
                s3v1beta1.BucketPublicAccessBlock{
                    metadata.name: "example-pab"
                    spec.forProvider: {
                        blockPublicAcls: False
                        blockPublicPolicy: False
                        bucketRef: {
                            name: "example-bucket"
                        }
                        ignorePublicAcls: False
                        region: "us-west-1"
                        restrictPublicBuckets: False
                    }
                }
                s3v1beta1.BucketVersioning{
                    metadata.name: "example-versioning"
                    spec.forProvider: {
                        bucketRef: {
                            name: "example-bucket"
                        }
                        region: "us-west-1"
                        versioningConfiguration: [
                            {
                                status: "Enabled"
                            },
                        ]
                    }
                }
            ]
            compositionPath: "apis/xstoragebucket/composition.yaml"
            xrPath: "examples/xstoragebuckets/example.yaml"
            xrdPath: "apis/xstoragebucket/definition.yaml"
            timeoutSeconds: 120
            validate: False
        }
    }
]
items = _items
