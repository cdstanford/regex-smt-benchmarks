;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{1,2}[\d]{1,2}([A-Za-z])?\s?[\d][A-Za-z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "RC2N9Mq"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "C" (seq.++ "2" (seq.++ "N" (seq.++ "9" (seq.++ "M" (seq.++ "q" ""))))))))
;witness2: "K60Y8pd"
(define-fun Witness2 () String (seq.++ "K" (seq.++ "6" (seq.++ "0" (seq.++ "Y" (seq.++ "8" (seq.++ "p" (seq.++ "d" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "0" "9")(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
