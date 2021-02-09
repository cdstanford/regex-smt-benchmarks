;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(user=([a-z0-9]+,)*(([a-z0-9]+){1});)?(group=([a-z0-9]+,)*(([a-z0-9]+){1});)?(level=[0-9]+;)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "group=195;"
(define-fun Witness1 () String (seq.++ "g" (seq.++ "r" (seq.++ "o" (seq.++ "u" (seq.++ "p" (seq.++ "=" (seq.++ "1" (seq.++ "9" (seq.++ "5" (seq.++ ";" "")))))))))))
;witness2: "user=9q,1;"
(define-fun Witness2 () String (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "=" (seq.++ "9" (seq.++ "q" (seq.++ "," (seq.++ "1" (seq.++ ";" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (str.to_re (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "=" ""))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "," ",")))(re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range ";" ";")))))(re.++ (re.opt (re.++ (str.to_re (seq.++ "g" (seq.++ "r" (seq.++ "o" (seq.++ "u" (seq.++ "p" (seq.++ "=" "")))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "," ",")))(re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range ";" ";")))))(re.++ (re.opt (re.++ (str.to_re (seq.++ "l" (seq.++ "e" (seq.++ "v" (seq.++ "e" (seq.++ "l" (seq.++ "=" "")))))))(re.++ (re.+ (re.range "0" "9")) (re.range ";" ";")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
