;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Za-z0-9.]+\s*)+,
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".,"
(define-fun Witness1 () String (seq.++ "." (seq.++ "," "")))
;witness2: "2.\u00A0DNK47\u00A0 ,\u00D2l\u0094"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "." (seq.++ "\xa0" (seq.++ "D" (seq.++ "N" (seq.++ "K" (seq.++ "4" (seq.++ "7" (seq.++ "\xa0" (seq.++ " " (seq.++ "," (seq.++ "\xd2" (seq.++ "l" (seq.++ "\x94" "")))))))))))))))

(assert (= regexA (re.++ (re.+ (re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (re.range "," ","))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
