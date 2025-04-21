package com.example.shop.enums;

public enum Rewards {

    BUY(0.05, "buying"),
    SELL(0.03, "selling"),
    EXCHANGE(0.1, "exchanging"),
    REPAIR(0.7, "repairing"),
    INFO_USER(0, "You offered an exchange to "),
    INFO_SELLER(0, "You received an exchange offer! ");

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
