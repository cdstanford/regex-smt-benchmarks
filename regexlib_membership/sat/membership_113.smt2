;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '/http:\\/\/(?:www.)?clipser\.com\/watch_video\/([0-9a-z-_]+)/i'
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\'/http:\//www2clipser.com/watch_video/z_-/i\'#I"
(define-fun Witness1 () String (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "\u{5c}" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "2" (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "w" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "_" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "/" (str.++ "z" (str.++ "_" (str.++ "-" (str.++ "/" (str.++ "i" (str.++ "'" (str.++ "#" (str.++ "I" "")))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00AD\'/http:\//clipser.com/watch_video/r/i\'#"
(define-fun Witness2 () String (str.++ "\u{ad}" (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "\u{5c}" (str.++ "/" (str.++ "/" (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "w" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "_" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "/" (str.++ "r" (str.++ "/" (str.++ "i" (str.++ "'" (str.++ "#" "")))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "'" (str.++ "/" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "\u{5c}" (str.++ "/" (str.++ "/" "")))))))))))(re.++ (re.opt (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (str.to_re (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "w" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "_" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "/" "")))))))))))))))))))))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))) (str.to_re (str.++ "/" (str.++ "i" (str.++ "'" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
