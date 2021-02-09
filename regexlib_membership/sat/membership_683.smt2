;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\{?[a-fA-F\d]{32}\}?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{3f2D6d8CA7b15ffE89d9aF888F0Ea8ff"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "3" (seq.++ "f" (seq.++ "2" (seq.++ "D" (seq.++ "6" (seq.++ "d" (seq.++ "8" (seq.++ "C" (seq.++ "A" (seq.++ "7" (seq.++ "b" (seq.++ "1" (seq.++ "5" (seq.++ "f" (seq.++ "f" (seq.++ "E" (seq.++ "8" (seq.++ "9" (seq.++ "d" (seq.++ "9" (seq.++ "a" (seq.++ "F" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "F" (seq.++ "0" (seq.++ "E" (seq.++ "a" (seq.++ "8" (seq.++ "f" (seq.++ "f" ""))))))))))))))))))))))))))))))))))
;witness2: "{f835BeF40BC8abAFAF2fCAF4999eE5fC"
(define-fun Witness2 () String (seq.++ "{" (seq.++ "f" (seq.++ "8" (seq.++ "3" (seq.++ "5" (seq.++ "B" (seq.++ "e" (seq.++ "F" (seq.++ "4" (seq.++ "0" (seq.++ "B" (seq.++ "C" (seq.++ "8" (seq.++ "a" (seq.++ "b" (seq.++ "A" (seq.++ "F" (seq.++ "A" (seq.++ "F" (seq.++ "2" (seq.++ "f" (seq.++ "C" (seq.++ "A" (seq.++ "F" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "e" (seq.++ "E" (seq.++ "5" (seq.++ "f" (seq.++ "C" ""))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "{" "{"))(re.++ ((_ re.loop 32 32) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "}" "}")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
