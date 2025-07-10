;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = http://(?:www\.|)uploaded\.to/\?id=[a-z0-9]{6}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Hhttp://www.uploaded.to/?id=z91s23"
(define-fun Witness1 () String (str.++ "H" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "e" (str.++ "d" (str.++ "." (str.++ "t" (str.++ "o" (str.++ "/" (str.++ "?" (str.++ "i" (str.++ "d" (str.++ "=" (str.++ "z" (str.++ "9" (str.++ "1" (str.++ "s" (str.++ "2" (str.++ "3" "")))))))))))))))))))))))))))))))))))
;witness2: "http://uploaded.to/?id=9pw7a9\u0095"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "e" (str.++ "d" (str.++ "." (str.++ "t" (str.++ "o" (str.++ "/" (str.++ "?" (str.++ "i" (str.++ "d" (str.++ "=" (str.++ "9" (str.++ "p" (str.++ "w" (str.++ "7" (str.++ "a" (str.++ "9" (str.++ "\u{95}" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ (re.union (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))) (str.to_re ""))(re.++ (str.to_re (str.++ "u" (str.++ "p" (str.++ "l" (str.++ "o" (str.++ "a" (str.++ "d" (str.++ "e" (str.++ "d" (str.++ "." (str.++ "t" (str.++ "o" (str.++ "/" (str.++ "?" (str.++ "i" (str.++ "d" (str.++ "=" ""))))))))))))))))) ((_ re.loop 6 6) (re.union (re.range "0" "9") (re.range "a" "z"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
