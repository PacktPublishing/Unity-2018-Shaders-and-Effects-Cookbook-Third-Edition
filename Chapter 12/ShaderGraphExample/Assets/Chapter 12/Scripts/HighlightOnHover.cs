using UnityEngine;

public class HighlightOnHover : MonoBehaviour
{

    public Color highlightColor = Color.red;

    private Material material;

    // Use this for initialization
    void Start()
    {
        material = GetComponent<MeshRenderer>().material;

        // Turn off glow
        OnMouseExit();
    }

    void OnMouseOver()
    {
        material.SetColor("Color_AA468061", highlightColor);
    }

    void OnMouseExit()
    {
        material.SetColor("Color_AA468061", Color.black);
    }

}
