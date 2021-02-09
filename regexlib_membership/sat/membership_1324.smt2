;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^0-9]*(?:(\d)[^0-9]*){10}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x7\x2\u0099956\u00AB1\u009C\u008681\u00A581\u00D6\x0\u0090_88"
(define-fun Witness1 () String (seq.++ "\x07" (seq.++ "\x02" (seq.++ "\x99" (seq.++ "9" (seq.++ "5" (seq.++ "6" (seq.++ "\xab" (seq.++ "1" (seq.++ "\x9c" (seq.++ "\x86" (seq.++ "8" (seq.++ "1" (seq.++ "\xa5" (seq.++ "8" (seq.++ "1" (seq.++ "\xd6" (seq.++ "\x00" (seq.++ "\x90" (seq.++ "_" (seq.++ "8" (seq.++ "8" ""))))))))))))))))))))))
;witness2: "0\u0083X29\u00DA\u0090[58604\u00F29F 3\u00BD\'\"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "\x83" (seq.++ "X" (seq.++ "2" (seq.++ "9" (seq.++ "\xda" (seq.++ "\x90" (seq.++ "[" (seq.++ "5" (seq.++ "8" (seq.++ "6" (seq.++ "0" (seq.++ "4" (seq.++ "\xf2" (seq.++ "9" (seq.++ "F" (seq.++ " " (seq.++ "3" (seq.++ "\xbd" (seq.++ "'" (seq.++ "\x5c" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x00" "/") (re.range ":" "\xff")))(re.++ ((_ re.loop 10 10) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\x00" "/") (re.range ":" "\xff"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
