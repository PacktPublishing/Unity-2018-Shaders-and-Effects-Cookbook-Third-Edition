using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorOnHover : MonoBehaviour
{

    Material material;

	// Use this for initialization
	void Start () {
        material = GetComponent<MeshRenderer>().material;	
	}

    void OnMouseOver()
    {
        material.SetColor("Color_AA468061", Color.red);
    }
}
