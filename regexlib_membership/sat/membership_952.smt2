;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <h([1-6])>([^<]*)</h([1-6])>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<h6>\"</h3>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "h" (seq.++ "6" (seq.++ ">" (seq.++ "\x22" (seq.++ "<" (seq.++ "/" (seq.++ "h" (seq.++ "3" (seq.++ ">" "")))))))))))
;witness2: "N\u00D9<h5>l</h6>\u00FB"
(define-fun Witness2 () String (seq.++ "N" (seq.++ "\xd9" (seq.++ "<" (seq.++ "h" (seq.++ "5" (seq.++ ">" (seq.++ "l" (seq.++ "<" (seq.++ "/" (seq.++ "h" (seq.++ "6" (seq.++ ">" (seq.++ "\xfb" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "h" "")))(re.++ (re.range "1" "6")(re.++ (re.range ">" ">")(re.++ (re.* (re.union (re.range "\x00" ";") (re.range "=" "\xff")))(re.++ (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "h" ""))))(re.++ (re.range "1" "6") (re.range ">" ">")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
