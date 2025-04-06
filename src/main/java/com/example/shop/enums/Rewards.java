package com.example.shop.enums;

public enum Rewards {

    BUY(0.05, "buying"),
    SELL(0.03, "selling"),
    EXCHANGE(0.1, "exchanging"),
    REPAIR(0.7, "repairing");


    private final double rewardPercentage;

    private final String operationType;

    public double getRewardPercentage(){
        return rewardPercentage;
    }

    public String getOperationType() {
        return operationType;
    }

    Rewards(double rewardPercentage, String operationType){
        this.rewardPercentage = rewardPercentage;
        this.operationType = operationType;
    }

}
