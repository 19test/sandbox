% http://www.mathworks.com/help/images/ref/imregister.html
fixed  = dicomread('knee1.dcm');
moving = dicomread('knee2.dcm');
imshowpair(fixed, moving,'Scaling','joint');
[optimizer, metric] = imregconfig('multimodal')
optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 300;
movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);
figure
imshowpair(fixed, movingRegistered,'Scaling','joint');