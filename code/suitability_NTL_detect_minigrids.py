import ee, datetime
import pandas as pd
import geos
import gdal
import fiona
import geopandas as gpd
import matplotlib.dates as mdates
from IPython.display import Image
from matplotlib import dates
from shapely.geometry import shape
import skimage


def fc2df(fc):
    # Convert a FeatureCollection into a pandas DataFrame
    # Features is a list of dict with the output
    features = fc.getInfo()['features']

    dictarr = []

    for f in features:
        # Store all attributes in a dict
        attr = f['properties']
        # and treat geometry separately
        attr['geometry'] = f['geometry']  # GeoJSON Feature!
        # attr['geometrytype'] = f['geometry']['type']
        dictarr.append(attr)

    df = gpd.GeoDataFrame(dictarr)
    # Convert GeoJSON features to shape
    df['geometry'] = map(lambda s: shape(s), df.geometry)
    return df

ee.Initialize()

collection = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG').filterDate('2019-01-01', '2020-01-01').select('avg_rad')

replacement = ee.Image(0);
    
def conditional(image):
	return image.where(image.lt(0.25), replacement)

collection = collection.map(conditional).median()

minigrids = ee.FeatureCollection('users/giacomofalchetta/minigridstanzania')

def bufferPoly(feature):
    return feature.buffer(2500)

minigrids = minigrids.map(bufferPoly)

lightsum = collection.reduceRegions(collection=minigrids, reducer=ee.Reducer.sum(), scale=450)

lightsum = fc2df(lightsum)

lightsum.to_csv("D:/OneDrive - FONDAZIONE ENI ENRICO MATTEI/Completed papers/INEQUALITY ASSESSMENT/One Earth/Revision 1/inequality_electrification_SSA/mgrids.csv")

