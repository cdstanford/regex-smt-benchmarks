;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d)(\.)(\d)+\s(x)\s(10)(e|E|\^)(-)?(\d)+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4.7\xCx\u00A010^-49"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "." (seq.++ "7" (seq.++ "\x0c" (seq.++ "x" (seq.++ "\xa0" (seq.++ "1" (seq.++ "0" (seq.++ "^" (seq.++ "-" (seq.++ "4" (seq.++ "9" "")))))))))))))
;witness2: "8.90\xDx\u008510e-381"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "." (seq.++ "9" (seq.++ "0" (seq.++ "\x0d" (seq.++ "x" (seq.++ "\x85" (seq.++ "1" (seq.++ "0" (seq.++ "e" (seq.++ "-" (seq.++ "3" (seq.++ "8" (seq.++ "1" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "x" "x")(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "1" (seq.++ "0" "")))(re.++ (re.union (re.range "E" "E")(re.union (re.range "^" "^") (re.range "e" "e")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.+ (re.range "0" "9")) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
