import imageio 
import numpy as np



def f_measure(map_gt,map_est):
	if not map_gt.shape == map_est.shape:
		print('The compared maps must have the same size')

	# Vectorize maps
	map_gt = np.ndarray.flatten(map_gt)
	map_est = np.ndarray.flatten(map_est)

	# Number of pixels
	N = map_gt.size
	# Indices of forged pixels in the ground truth
	i_pos = np.where(map_gt == 1)
	# Number of forged pixels in the ground truth
	n_pos = map_gt[i_pos].shape[0]

	# True Positive Rate: fraction of forged pixels correctly identified as forged
	tp = np.where(map_gt[i_pos]==map_est[i_pos])[0].shape[0]
	tpr = tp / n_pos
	# False Negative Rate: fraction of forged pixels wrongly identified as non-forged
	fn = n_pos-tp
	fnr = fn / n_pos
	# False Positive Rate: fraction of non-forged pixels wrongly identified as forged
	# Indices of non-forged pixels in the ground truth
	i_neg = np.where(map_gt == 0)
	fp = np.where(map_est[i_neg]==1)[0].shape[0]
	fpr = fp / (N-n_pos)

	F = 2*tp / (2*tp+fn+fp)

	return F, tp, fn, fp



if __name__=="__main__":
	
	map_gt = imageio.imread('ground_truth_map.bmp')
	map_gt = np.array(map_gt/255,dtype=np.uint8)

	map_est = imageio.imread('estimated_map.bmp')
	map_est = np.array(map_est/255,dtype=np.uint8)

	F,_,_,_ = f_measure(map_gt,map_est)
	print(F)
