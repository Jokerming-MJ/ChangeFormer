#!/usr/bin/env bash

#GPUs
gpus=0

#PATHs
checkpoint_root=/media/lidan/ssd2/ChangeFormer/checkpoints
vis_root=/media/lidan/ssd2/ChangeFormer/vis
data_name=LEVIR #LEVIR, DSIFN

#Image Details
img_size=256
batch_size=8
lr=0.01
max_epochs=200

#Network
net_G=ChangeFormerV6
#ChangeFormerV1/2/3/4
#V1: Transformer encoder and COnvolutional decoder
#V2: Transformer Encoder -> Difference -> Transformer Decoder
#V3: Transformer ENcoder -> MLP -> DIff -> Convup
#V4: Transformer Encoder -> MLP -> DIff -> PixelShiffel upsample

lr_policy=linear
optimizer=sgd #sgd, adam
loss=ce #ce, fl (Focal Loss), miou
multi_scale_train=True
multi_scale_infer=False
shuffle_AB=False

#Initializing from pretrained weights
pretrain=/media/lidan/ssd2/ChangeFormer/pretrained_segformer/segformer.b2.512x512.ade.160k.pth

#Train and Validation splits
split=train #trainval
split_val=test #test
project_name=CD_${net_G}_${data_name}_b${batch_size}_lr${lr}_${optimizer}_${split}_${split_val}_${max_epochs}_${lr_policy}_${loss}_multi_train_${multi_scale_train}_multi_infer_${multi_scale_infer}_shuffle_AB_${shuffle_AB}

CUDA_VISIBLE_DEVICES=0 python main_cd.py --img_size ${img_size} --loss ${loss} --checkpoint_root ${checkpoint_root} --vis_root ${vis_root} --lr_policy ${lr_policy} --optimizer ${optimizer} --pretrain ${pretrain} --split ${split} --split_val ${split_val} --net_G ${net_G} --multi_scale_train ${multi_scale_train} --multi_scale_infer ${multi_scale_infer} --gpu_ids ${gpus} --max_epochs ${max_epochs} --project_name ${project_name} --batch_size ${batch_size} --shuffle_AB ${shuffle_AB} --data_name ${data_name}  --lr ${lr}