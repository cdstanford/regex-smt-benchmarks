;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(?'num'\d+(\.\d+)?)\s*(?'unit'((w(eek)?)|(wk)|(d(ay)?)|(h(our)?)|(hr))s?)(\s*$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x97879999.9\xDhour\xA"
(define-fun Witness1 () String (seq.++ "\x09" (seq.++ "7" (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "\x0d" (seq.++ "h" (seq.++ "o" (seq.++ "u" (seq.++ "r" (seq.++ "\x0a" "")))))))))))))))))
;witness2: " 38.588 hr"
(define-fun Witness2 () String (seq.++ " " (seq.++ "3" (seq.++ "8" (seq.++ "." (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ " " (seq.++ "h" (seq.++ "r" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.+ (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ (re.union (re.++ (re.range "w" "w") (re.opt (str.to_re (seq.++ "e" (seq.++ "e" (seq.++ "k" ""))))))(re.union (str.to_re (seq.++ "w" (seq.++ "k" "")))(re.union (re.++ (re.range "d" "d") (re.opt (str.to_re (seq.++ "a" (seq.++ "y" "")))))(re.union (re.++ (re.range "h" "h") (re.opt (str.to_re (seq.++ "o" (seq.++ "u" (seq.++ "r" "")))))) (str.to_re (seq.++ "h" (seq.++ "r" ""))))))) (re.opt (re.range "s" "s"))) (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
