using UnityEngine;

public class NormalExtruder : MonoBehaviour
{
    [Range(-0.0001f, 0.0001f)]
    public float amount = 0;

    // Use this for initialization
    void Start()
    {
        Material material = GetComponent<Renderer>().sharedMaterial;
        Material newMaterial = new Material(material);
        newMaterial.SetFloat("_Amount", amount);
        GetComponent<Renderer>().material = newMaterial;
    }
}