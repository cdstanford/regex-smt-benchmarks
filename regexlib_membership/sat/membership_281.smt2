;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z]{2}[0-9]{1,2}\s{0,1}[0-9]{1,2}[a-zA-Z]{2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A7\u00D0Yb579MI\u00EF"
(define-fun Witness1 () String (seq.++ "\xa7" (seq.++ "\xd0" (seq.++ "Y" (seq.++ "b" (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ "M" (seq.++ "I" (seq.++ "\xef" "")))))))))))
;witness2: "xA8799al"
(define-fun Witness2 () String (seq.++ "x" (seq.++ "A" (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "a" (seq.++ "l" "")))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
