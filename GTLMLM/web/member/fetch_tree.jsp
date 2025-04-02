<?php
define('DB_SERVER', 'localhost');
define('DB_USER', 'u232973465_cpUserName');
define('DB_PASS', '0102pk@PKCP');
define('DB_NAME', 'u232973465_cpDataBase');

$con = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
if (mysqli_connect_errno()) {
    die("Failed to connect to MySQL: " . mysqli_connect_error());
}

// Function to recursively fetch members
function fetchTree($parentId, $position) {
    global $con;
    $tree = [];

    $sql = "SELECT * FROM members WHERE parent_id = ? AND position = ?";
    $stmt = $con->prepare($sql);
    $stmt->bind_param("is", $parentId, $position);
    $stmt->execute();
    $result = $stmt->get_result();

    while ($row = $result->fetch_assoc()) {
        $member = [
            'id' => $row['member_id'],
            'name' => $row['name'],
            'left' => fetchTree($row['member_id'], 'left'), // Recursive call for left child
            'right' => fetchTree($row['member_id'], 'right') // Recursive call for right child
        ];
        $tree[] = $member;
    }
    return $tree;
}

// Fetch the tree starting from the root
$rootId = 1; // Replace with the actual root ID
$genealogyTree = fetchTree($rootId, NULL);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Genealogy Tree</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<div class="container text-center mt-5">
    <h2>Genealogy Tree</h2>
    <div class="tree-container">
        <?php displayTree($genealogyTree); ?>
    </div>
</div>

</body>
</html>
