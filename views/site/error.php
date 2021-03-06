<?php

/* @var $this yii\web\View */
/* @var $name string */
/* @var $message string */
/* @var $exception Exception */

use yii\helpers\Html;

$this->title = $name;
?>
<div class="site-error col-lg-11">
    <br>

    <h1><?= Html::encode($this->title) ?></h1>
    <br>
    <div class="alert alert-danger">
        <?= nl2br(Html::encode($message)) ?>
    </div>
    <br>

    <p>
        The above error occurred while the Web server was processing your request.
    </p>
    <p>
        Please contact us if you think this is a server error. Thank you.
    </p>
    <br>
</div>
