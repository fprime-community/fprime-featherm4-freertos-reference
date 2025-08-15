
def test_cmd_no_op(fprime_test_api):
    command_count = fprime_test_api.get_command_test_history().size()
    fprime_test_api.send_and_assert_command("ReferenceDeployment.cmdDisp.CMD_NO_OP", max_delay=0.500)
    assert fprime_test_api.get_command_test_history().size() == (command_count + 1)

def test_cmd_no_op_string(fprime_test_api):
    command_count = fprime_test_api.get_command_test_history().size()
    result = fprime_test_api.send_and_assert_command(
        "ReferenceDeployment.cmdDisp.CMD_NO_OP_STRING",
        args=["hello, fprime-featherm4-freertos!"],
        events=["ReferenceDeployment.cmdDisp.NoOpStringReceived"],
        max_delay=0.5)
    assert result[1].display_text == "Received a NO-OP string=hello, fprime-featherm4-freertos!"
    assert fprime_test_api.get_command_test_history().size() == (command_count + 1)
