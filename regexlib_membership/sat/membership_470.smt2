;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://(?:www\.|)uploaded\.to/\?id=[a-z0-9]{6}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Hhttp://www.uploaded.to/?id=z91s23"
(define-fun Witness1 () String (seq.++ "H" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "u" (seq.++ "p" (seq.++ "l" (seq.++ "o" (seq.++ "a" (seq.++ "d" (seq.++ "e" (seq.++ "d" (seq.++ "." (seq.++ "t" (seq.++ "o" (seq.++ "/" (seq.++ "?" (seq.++ "i" (seq.++ "d" (seq.++ "=" (seq.++ "z" (seq.++ "9" (seq.++ "1" (seq.++ "s" (seq.++ "2" (seq.++ "3" "")))))))))))))))))))))))))))))))))))
;witness2: "http://uploaded.to/?id=9pw7a9\u0095"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "u" (seq.++ "p" (seq.++ "l" (seq.++ "o" (seq.++ "a" (seq.++ "d" (seq.++ "e" (seq.++ "d" (seq.++ "." (seq.++ "t" (seq.++ "o" (seq.++ "/" (seq.++ "?" (seq.++ "i" (seq.++ "d" (seq.++ "=" (seq.++ "9" (seq.++ "p" (seq.++ "w" (seq.++ "7" (seq.++ "a" (seq.++ "9" (seq.++ "\x95" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ (re.union (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))) (str.to_re ""))(re.++ (str.to_re (seq.++ "u" (seq.++ "p" (seq.++ "l" (seq.++ "o" (seq.++ "a" (seq.++ "d" (seq.++ "e" (seq.++ "d" (seq.++ "." (seq.++ "t" (seq.++ "o" (seq.++ "/" (seq.++ "?" (seq.++ "i" (seq.++ "d" (seq.++ "=" ""))))))))))))))))) ((_ re.loop 6 6) (re.union (re.range "0" "9") (re.range "a" "z"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
