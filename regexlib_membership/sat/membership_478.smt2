;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /rapidshare\.com\/files\/(\d+)\/([^\'^\"^\s^>^<^\\^\/]+)/
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "/rapidshare.com/files/9/\u0080/\x4)\u00EE"
(define-fun Witness1 () String (str.++ "/" (str.++ "r" (str.++ "a" (str.++ "p" (str.++ "i" (str.++ "d" (str.++ "s" (str.++ "h" (str.++ "a" (str.++ "r" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "9" (str.++ "/" (str.++ "\u{80}" (str.++ "/" (str.++ "\u{04}" (str.++ ")" (str.++ "\u{ee}" ""))))))))))))))))))))))))))))))
;witness2: "/rapidshare.com/files/9/d}/\x15"
(define-fun Witness2 () String (str.++ "/" (str.++ "r" (str.++ "a" (str.++ "p" (str.++ "i" (str.++ "d" (str.++ "s" (str.++ "h" (str.++ "a" (str.++ "r" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "/" (str.++ "9" (str.++ "/" (str.++ "d" (str.++ "}" (str.++ "/" (str.++ "\u{15}" "")))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "/" (str.++ "r" (str.++ "a" (str.++ "p" (str.++ "i" (str.++ "d" (str.++ "s" (str.++ "h" (str.++ "a" (str.++ "r" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ "/" "")))))))))))))))))))))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "(" ".")(re.union (re.range "0" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))))))) (re.range "/" "/")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
