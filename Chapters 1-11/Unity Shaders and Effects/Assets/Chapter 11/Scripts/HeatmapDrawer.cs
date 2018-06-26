using UnityEngine;

public class HeatmapDrawer : MonoBehaviour
{

    public Vector4[] positions;
    public float[] radiuses;
    public float[] intensities;
    public Material material;

    void Start()
    {
        material.SetInt("_Points_Length", positions.Length);

        material.SetVectorArray("_Points", positions);

        Vector4[] properties = new Vector4[positions.Length];

        for (int i = 0; i < positions.Length; i++)
        {
            properties[i] = new Vector2(radiuses[i], intensities[i]);
        }

        material.SetVectorArray("_Properties", properties);
      
    }
}