;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\([0]\d{1}\))(\d{7}$)|(^\([0][2]\d{1}\))(\d{6,8}$)|([0][8][0][0])([\s])(\d{5,8}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"0800\u00A011273"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "0" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "\xa0" (seq.++ "1" (seq.++ "1" (seq.++ "2" (seq.++ "7" (seq.++ "3" ""))))))))))))
;witness2: "(06)8889808"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "6" (seq.++ ")" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "8" ""))))))))))))

(assert (= regexA (re.union (re.++ (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "(" (seq.++ "0" "")))(re.++ (re.range "0" "9") (re.range ")" ")")))) (re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))(re.union (re.++ (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ "2" ""))))(re.++ (re.range "0" "9") (re.range ")" ")")))) (re.++ ((_ re.loop 6 8) (re.range "0" "9")) (str.to_re ""))) (re.++ (str.to_re (seq.++ "0" (seq.++ "8" (seq.++ "0" (seq.++ "0" "")))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.++ ((_ re.loop 5 8) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
