using UnityEngine;

[ExecuteInEditMode]
public class ShowNormals : MonoBehaviour {

    public float length = 1;

    public Vector3 bias;

    // Update is called once per frame
    void Update() {

        Mesh mesh = GetComponent<MeshFilter>().sharedMesh;

        Vector3[] vertices = mesh.vertices;
        Vector3[] normals = mesh.normals;

        for (var i = 0; i < normals.Length; i++)
        {
            Vector3 pos = vertices[i];
            pos.x *= transform.localScale.x;
            pos.y *= transform.localScale.y;
            pos.z *= transform.localScale.z;
            pos += transform.position + bias;

            Debug.DrawLine(pos, pos + normals[i] * length, Color.red);
        }
    }
}
