<?php
/**
 * Created by PhpStorm.
 * User: luiz
 * Date: 4/4/2015
 * Time: 2:45 PM
 */

class calendarControl extends Control{
    private $_month = array(
        1 => 'Janeiro',
        2 => 'Fevereiro',
        3 => 'Março',
        4 => 'Abril',
        5 => 'Maio',
        6 => 'Junho',
        7 => 'Julho',
        8 => 'Agosto',
        9 => 'Setembro',
        10 => 'Outubro',
        11 => 'Novembro',
        12 => 'Dezembro',
    );

    private $_daysOfWeek = array(
        0 => 'Domingo',
        1 => 'Segunda',
        2 => 'Terça',
        3 => 'Quarta',
        4 => 'Quinta',
        5 => 'Sexta',
        6 => 'Sabado',
    );

    private $_daysOfWeekShort = array(
        0 => 'D',
        1 => 'S',
        2 => 'T',
        3 => 'Q',
        4 => 'Q',
        5 => 'S',
        6 => 'S',
    );

    public function render($year = null, $month = null, $day = null){
        $this->view()->loadTemplate('calendar');

        if($month == null)
            $month = $this->getTodayMonth();
        if($year == null)
            $year = $this->getTodayYear();
        if($day == null)
            $day = $this->getTodayDay();

        $daysInMonth = $this->daysInMonth($month,$year);
        $monthStart = $this->monthStart($month,$year);
        $monthName = $this->_month[$month];

        $this->view()->setVariable('year', $year);
        $this->view()->setVariable('daysInMonth', $daysInMonth);

        $this->view()->setVariable('monthStart', $monthStart);
        $this->view()->setVariable('monthName', $monthName);
        $this->view()->setVariable('today', $day);
        $this->view()->setVariable('daysOfWeekNames', $this->_daysOfWeekShort);
        return $this->view()->render();
    }

    private function daysInMonth($month, $year){
        return date('t',strtotime($year.'-'.$month.'-01'));
    }

    private function monthStart($month, $year){
        return date('w',strtotime($year.'-'.$month.'-01'));
    }

    private function getTodayMonth(){
        return date('n',time());
    }

    private function getTodayYear(){
        return date("Y",time());
    }

    private function getTodayDayOfWeek(){
        return date("w",time());
    }

    private function getTodayDay(){
        return date("j",time());
    }
}