;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(user=([a-z0-9]+,)*(([a-z0-9]+){1});)?(group=([a-z0-9]+,)*(([a-z0-9]+){1});)?(level=[0-9]+;)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "group=195;"
(define-fun Witness1 () String (str.++ "g" (str.++ "r" (str.++ "o" (str.++ "u" (str.++ "p" (str.++ "=" (str.++ "1" (str.++ "9" (str.++ "5" (str.++ ";" "")))))))))))
;witness2: "user=9q,1;"
(define-fun Witness2 () String (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "=" (str.++ "9" (str.++ "q" (str.++ "," (str.++ "1" (str.++ ";" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (str.to_re (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "=" ""))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "," ",")))(re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range ";" ";")))))(re.++ (re.opt (re.++ (str.to_re (str.++ "g" (str.++ "r" (str.++ "o" (str.++ "u" (str.++ "p" (str.++ "=" "")))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "," ",")))(re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range ";" ";")))))(re.++ (re.opt (re.++ (str.to_re (str.++ "l" (str.++ "e" (str.++ "v" (str.++ "e" (str.++ "l" (str.++ "=" "")))))))(re.++ (re.+ (re.range "0" "9")) (re.range ";" ";")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
