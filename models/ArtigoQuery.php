<?php

namespace app\models;

/**
 * This is the ActiveQuery class for [[Artigo]].
 *
 * @see Artigo
 */
class ArtigoQuery extends \yii\db\ActiveQuery
{
    /*public function active()
    {
        return $this->andWhere('[[status]]=1');
    }*/

    /**
     * {@inheritdoc}
     * @return Artigo[]|array
     */
    public function all($db = null)
    {
        return parent::all($db);
    }

    /**
     * {@inheritdoc}
     * @return Artigo|array|null
     */
    public function one($db = null)
    {
        return parent::one($db);
    }
}
