<?php
/**
 * Class Calendar
 *
 * A calendar widget
 *
 * @author  Eder Luiz
 * @email   eder.luiz.correa@gmail.com
 */

class calendarControl extends Control{

    /**
     * Month names
     *
     * @var array
     */
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

    /**
     * Days of week names
     *
     * @var array
     */
    private $_daysOfWeek = array(
        0 => 'Domingo',
        1 => 'Segunda',
        2 => 'Terça',
        3 => 'Quarta',
        4 => 'Quinta',
        5 => 'Sexta',
        6 => 'Sabado',
    );

    /**
     * Days of week shorts
     *
     * @var array
     */
    private $_daysOfWeekShort = array(
        0 => 'D',
        1 => 'S',
        2 => 'T',
        3 => 'Q',
        4 => 'Q',
        5 => 'S',
        6 => 'S',
    );

    /**
     * Renders the calendar
     *
     * @param   null|int    $year      - Year to render    (null for current year)
     * @param   null|int    $month     - Month to render   (null for current month)
     * @param   null|int    $day       - Day to render     (null for current day)
     * @return  string                 - The calendar html table
     */
    public function render($year = null, $month = null, $day = null){
        $this->view()->loadTemplate('calendar');

        if($month == null)
            $month = $this->getTodayMonth();
        if($year == null)
            $year = $this->getTodayYear();
        if($day == null)
            $day = $this->getTodayDay();

        $daysInMonth = $this->daysInMonth($month,$year);
        $monthStart  = $this->monthStart($month,$year);
        $monthName   = $this->_month[$month];

        $this->view()->setVariable('year', $year);
        $this->view()->setVariable('daysInMonth', $daysInMonth);
        $this->view()->setVariable('monthStart', $monthStart);
        $this->view()->setVariable('monthName', $monthName);
        $this->view()->setVariable('month', $month);
        $this->view()->setVariable('today', $day);
        $this->view()->setVariable('daysOfWeekNames', $this->_daysOfWeekShort);
        return $this->view()->render();
    }

    /**
     * Returns the number of days existing in a month
     *
     * This will return precisely the number of the days
     * existing in this month, regarding it's 30 or 31 or
     * even 28 or 29 for february leap years
     *
     * @param   int             $month      - The month to check
     * @param   int             $year       - The year of this month
     * @return  bool|string
     */
    private function daysInMonth($month, $year){
        return date('t',strtotime($year.'-'.$month.'-01'));
    }

    /**
     * The week day that a month starts
     *
     * @param   int             $month      - The month to check
     * @param   int             $year       - The year to check
     * @return  bool|string
     */
    private function monthStart($month, $year){
        return date('w',strtotime($year.'-'.$month.'-01'));
    }

    /**
     * Returns an int for current month
     *
     * @return bool|string|int
     */
    private function getTodayMonth(){
        return date('n',time());
    }

    /**
     * Returns an int for current year
     *
     * @return bool|string|int
     */
    private function getTodayYear(){
        return date("Y",time());
    }

    /**
     * Returns an int for the day of week for current date
     *
     * @return bool|string|int
     */
    private function getTodayDayOfWeek(){
        return date("w",time());
    }

    /**
     * Returns an int for current day
     *
     * @return bool|string|int
     */
    private function getTodayDay(){
        return date("j",time());
    }
}