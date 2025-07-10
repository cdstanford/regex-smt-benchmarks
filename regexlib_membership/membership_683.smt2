;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{?[a-fA-F\d]{32}\}?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "{3f2D6d8CA7b15ffE89d9aF888F0Ea8ff"
(define-fun Witness1 () String (str.++ "{" (str.++ "3" (str.++ "f" (str.++ "2" (str.++ "D" (str.++ "6" (str.++ "d" (str.++ "8" (str.++ "C" (str.++ "A" (str.++ "7" (str.++ "b" (str.++ "1" (str.++ "5" (str.++ "f" (str.++ "f" (str.++ "E" (str.++ "8" (str.++ "9" (str.++ "d" (str.++ "9" (str.++ "a" (str.++ "F" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "F" (str.++ "0" (str.++ "E" (str.++ "a" (str.++ "8" (str.++ "f" (str.++ "f" ""))))))))))))))))))))))))))))))))))
;witness2: "{f835BeF40BC8abAFAF2fCAF4999eE5fC"
(define-fun Witness2 () String (str.++ "{" (str.++ "f" (str.++ "8" (str.++ "3" (str.++ "5" (str.++ "B" (str.++ "e" (str.++ "F" (str.++ "4" (str.++ "0" (str.++ "B" (str.++ "C" (str.++ "8" (str.++ "a" (str.++ "b" (str.++ "A" (str.++ "F" (str.++ "A" (str.++ "F" (str.++ "2" (str.++ "f" (str.++ "C" (str.++ "A" (str.++ "F" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "e" (str.++ "E" (str.++ "5" (str.++ "f" (str.++ "C" ""))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "{" "{"))(re.++ ((_ re.loop 32 32) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "}" "}")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
